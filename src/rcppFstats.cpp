#include "rcppFstats.h"
#include <RcppArmadillo.h>

SEXP rcppFstats(SEXP dat, SEXP mod, SEXP mod0, SEXP adjust){
	
	try  {
		// Setup
		arma::mat datc = Rcpp::as<arma::mat>(dat);
		arma::mat modc = Rcpp::as<arma::mat>(mod);
		arma::mat mod0c = Rcpp::as<arma::mat>(mod0);
		double adjustc = Rcpp::as<double>(adjust);
		int n = datc.n_rows;
		int m = datc.n_cols;
		int df = modc.n_cols;
		int df0 = mod0c.n_cols;

		arma::vec fstats = arma::zeros<arma::vec>(m);
		arma::vec res = arma::zeros<arma::vec>(n);
		arma::vec res0 = arma::zeros<arma::vec>(n);

		double ss,ss0; 
	
		// Actual computations
	
		for(int i=0; i < m; i++){
		  res = datc.col(i) - modc*arma::solve(modc,datc.col(i));
		  res0 = datc.col(i) - mod0c*arma::solve(mod0c,datc.col(i));
		  ss = arma::as_scalar( arma::trans(res)*res);
		  ss0 = arma::as_scalar( arma::trans(res0)*res0);
		  fstats(i) = ((ss0 - ss)/(df-df0))/(adjustc + ss/(n-df));
		}
	
		// Finish up
		return Rcpp::wrap(fstats);
	} catch( std::exception &ex ) {
		forward_exception_to_r( ex );
	} catch(...) {
		::Rf_error( "c++ exception (unknown reason)" );
	}
	return R_NilValue; // -Wall
	
	
}

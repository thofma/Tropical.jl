using Tropical, Test

###
# Examples involving tropical numbers of Maclagan-Sturmfels
#   (only computations with tropical numbers are included)
###

T = tropical_ring(min)

@testset "Matrices" begin
  # Example 1.2.2.
  # adjacency matrices of graphs
  
  D_G = matrix(T, [[0,1,3,7],[2,0,1,3],[4,5,0,1],[6,3,1,0]])
  @test D_G^2 == T[0 1 2 4;
                   2 0 1 2;
                   4 4 0 1;
                   5 3 1 0]

  @test D_G^3 == T[0 1 2 3;
                   2 0 1 2;
                   4 4 0 1;
                   5 3 1 0]

  ## Example 5.1.6
  ## tropical Eigenvalues and Eigenspaces
  ## (only including the determinant/permanent part,
  
  A = matrix(T, [[1, 0, 1], [0, 1, 2], [1, 2, 1]])
  Tt, t = T["t"]
  E = identity_matrix(Tt, 3)

  f = permanent(A + t*E)
  @test f == t^3 + 1 * t^2 + t + 1
  @test f(0) == 0
  # f should be (t+0)^3*(t+1), but it is not
  B = A + A^2 + A^3
  @test B == T[0 0 1;
               0 0 1;
               1 1 1]

  # Example 5.3.19 (for n=4)
  # tropical minors (towards defining tropical ranks, related to ranks of matroids)
  
  C4 = matrix(T, [[1,0,0,0],[0,1,0,0],[0,0,1,0],[0,0,0,1]])
  # this is not the unit matrix in tropical geometry
  
  # Are minors determinants or matrices?

  # m = minors(C4, 2) # 2x2 minors
  # m = minors(C4, 3) # 3x3 minors
end

@testset "Polynomial" begin
  # Example 1.2.4
  # tropical geometry and linear programming
  Tx, x = PolynomialRing(T, "x" => 1:2)
  p = 2*x[1]^4+5*x[1]^3*x[2]+11*x[1]^2*x[2]^2+7*x[1]*x[2]^3+3*x[2]^4
  @test p^3 == (6)*x[1]^12 + (9)*x[1]^11*x[2] + (12)*x[1]^10*x[2]^2 +
               (11)*x[1]^9*x[2]^3 + (7)*x[1]^8*x[2]^4 + (10)*x[1]^7*x[2]^5 +
               (13)*x[1]^6*x[2]^6 + (12)*x[1]^5*x[2]^7 + (8)*x[1]^4*x[2]^8 +
               (11)*x[1]^3*x[2]^9 + (17)*x[1]^2*x[2]^10 + (13)*x[1]*x[2]^11 +
               (9)*x[2]^12
end


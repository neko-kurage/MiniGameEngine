static class Matrix {
  Matrix() {
    
  }
  
  static PVector rotateX(PVector vector, float rad) {
    PVector vectorResult = new PVector();
    vectorResult = transform(vector, rotateMatrixX(rad));
    
    return vectorResult;
  }
  
  static PVector rotateY(PVector vector, float rad) {
    PVector vectorResult = new PVector();
    vectorResult = transform(vector, rotateMatrixY(rad));
    
    return vectorResult;
  }
  
  static PVector rotateZ(PVector vector, float rad) {
    PVector vectorResult = new PVector();
    vectorResult = transform(vector, rotateMatrixZ(rad));
    
    return vectorResult;
  }
  
  static float[][] rotateMatrixX(float radX) {
      float[][] resultMatrix = {
        {1, 0, 0},
        {0, cos(radX), -sin(radX)},
        {0, sin(radX), cos(radX)}
      };
      
      return resultMatrix;
  }

  static float[][] rotateMatrixY(float radY) {
      float[][] resultMatrix = {
        {cos(radY), 0, sin(radY)},
        {0, 1, 0},
        {-sin(radY), 0, cos(radY)}
      };
      
      return resultMatrix;
  }

  static float[][] rotateMatrixZ(float radZ) {
    float[][] resultMatrix = {
        {cos(radZ), -sin(radZ), 0},
        {sin(radZ), cos(radZ), 0},
        {0, 0, 1}
    };
    
    return resultMatrix;
  }
  
  /**
   * 行列同士を掛け合わせる
   * matrix1のほうが先に実行される
   * matrix1 - 先に実行される行列
   * matrix2 - 後に実行される行列
   * @param {array} dest - 結果を保存するようの変数を指定
   */
  static float[][] multiply(float[][] matA, float[][] matB) {
      float[][] matrixResult = new float[2][2];
    
      matrixResult[0][0] = matB[0][0] * matA[0][0] + matB[0][1] * matA[1][0] + matB[0][2] * matA[2][0];
      matrixResult[0][1] = matB[0][0] * matA[0][1] + matB[0][1] * matA[1][1] + matB[0][2] * matA[2][1];
      matrixResult[0][2] = matB[0][0] * matA[0][2] + matB[0][1] * matA[1][2] + matB[0][2] * matA[2][2];

      matrixResult[1][0] = matB[1][0] * matA[0][0] + matB[1][1] * matA[1][0] + matB[1][2] * matA[2][0];
      matrixResult[1][1] = matB[1][0] * matA[0][1] + matB[1][1] * matA[1][1] + matB[1][2] * matA[2][1];
      matrixResult[1][2] = matB[1][0] * matA[0][2] + matB[1][1] * matA[1][2] + matB[1][2] * matA[2][2];

      matrixResult[2][0] = matB[2][0] * matA[0][0] + matB[2][1] * matA[1][0] + matB[2][2] * matA[2][0];
      matrixResult[2][1] = matB[2][0] * matA[0][1] + matB[2][1] * matA[1][1] + matB[2][2] * matA[2][1];
      matrixResult[2][2] = matB[2][0] * matA[0][2] + matB[2][1] * matA[1][2] + matB[2][2] * matA[2][2];

      return matrixResult;
  }
  
  /**
   * 座標に行列を掛け合わせる
   * 結果は連想配列{x, y, z}で返される
   * x - x座標
   * y - y座標
   * z - z座標
   * matrix - 座標に対して実行する行列
   */
  static PVector transform(PVector vector, float[][] matrix) {
    PVector vectorResult = new PVector();
  
    vectorResult.x = vector.x * matrix[0][0] + vector.y * matrix[0][1] + vector.z * matrix[0][2];
    vectorResult.y = vector.x * matrix[1][0] + vector.y * matrix[1][1] + vector.z * matrix[1][2];
    vectorResult.z = vector.x * matrix[2][0] + vector.y * matrix[2][1] + vector.z * matrix[2][2];

    return vectorResult;
  }
}

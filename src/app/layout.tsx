import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import Navbar from './components/Navbar';
import Login from './pages/Login';
import ProductList from './pages/ProductList';
import CategoryProducts from './pages/CategoryProducts';

function App() {
  return (
    <Router>
      <div className="min-h-screen bg-gray-50">
        <Navbar />
        <main className="max-w-7xl mx-auto py-6 sm:px-6 lg:px-8">
          <Routes>
            <Route path="/login" element={<Login />} />
            <Route path="/" element={<ProductList />} />
            <Route path="/category/:slug" element={<CategoryProducts />} />
          </Routes>
        </main>
      </div>
    </Router>
  );
}

export default App;
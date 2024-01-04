package com.example.exam_dart.service;

import com.example.exam_dart.entity.Customer;

import java.util.List;

public interface CustomerService {
    List<Customer> getAllCustomer();
    Customer createCustomer(Customer customer);
}

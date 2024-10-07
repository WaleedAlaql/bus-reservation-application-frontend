package com.waleed.bus_reservation_application;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class BusReservationApplication {

	public static void main(String[] args) {
		System.out.println("Starting BusReservationApplication...");
		try {
			SpringApplication.run(BusReservationApplication.class, args);
			System.out.println("BusReservationApplication started successfully.");
		} catch (Exception e) {
			System.err.println("Error starting BusReservationApplication: " + e.getMessage());
			e.printStackTrace();
		}
	}
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecentVisits extends StatelessWidget {
  const RecentVisits({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13),
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Recent Visits",
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                    letterSpacing: -0.6,
                  ),
                ),
                const SizedBox(height: 10,),
                
                Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "15 May 2024",
                                style: GoogleFonts.dmSans(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                "Cough and mild fever, headache",
                                style: TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.w600,
                                ),
                                )
                            ],
                          ),
            
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "4 June",
                                    style: GoogleFonts.dmSans(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Text(
                                    "Follow Up",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 8,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(width: 10,),
                              const Icon(
                                Icons.check_circle,
                                color: Color.fromARGB(255, 103, 241, 108),
                                size: 17,
                              )
                            ],
                          ),
            
                          Row(
                            children: [
                              Icon(
                                Icons.file_download_outlined,
                                color: Colors.pink.shade300,
                              ),
            
                              const SizedBox(width: 5,),
                              const Icon(
                                Icons.more_horiz,
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
    
                Divider(
                  color: Colors.grey.shade300,
                  thickness: 2,
                ),
    
                Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "15 May 2024",
                                style: GoogleFonts.dmSans(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                "Cough and mild fever, headache",
                                style: TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.w600,
                                ),
                                )
                            ],
                          ),
            
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "4 June",
                                    style: GoogleFonts.dmSans(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Text(
                                    "Follow Up",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 8,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(width: 10,),
                              const Icon(
                                Icons.check_circle,
                                color: Color.fromARGB(255, 103, 241, 108),
                                size: 17,
                              )
                            ],
                          ),
            
                          Row(
                            children: [
                              Icon(
                                Icons.file_download_outlined,
                                color: Colors.pink.shade300,
                              ),
            
                              const SizedBox(width: 5,),
                              const Icon(
                                Icons.more_horiz,
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
    
                Divider(
                  color: Colors.grey.shade300,
                  thickness: 2,
                ),
    
                Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "15 May 2024",
                                style: GoogleFonts.dmSans(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                "Cough and mild fever, headache",
                                style: TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.w600,
                                ),
                                )
                            ],
                          ),
            
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "4 June",
                                    style: GoogleFonts.dmSans(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Text(
                                    "Follow Up",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 8,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(width: 10,),
                              const Icon(
                                Icons.check_circle,
                                color: Color.fromARGB(255, 103, 241, 108),
                                size: 17,
                              )
                            ],
                          ),
            
                          Row(
                            children: [
                              Icon(
                                Icons.file_download_outlined,
                                color: Colors.pink.shade300,
                              ),
            
                              const SizedBox(width: 5,),
                              const Icon(
                                Icons.more_horiz,
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
    
                Divider(
                  color: Colors.grey.shade300,
                  thickness: 2,
                ),
    
                Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "15 May 2024",
                                style: GoogleFonts.dmSans(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                "Cough and mild fever, headache",
                                style: TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.w600,
                                ),
                                )
                            ],
                          ),
            
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "4 June",
                                    style: GoogleFonts.dmSans(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Text(
                                    "Follow Up",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 8,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(width: 10,),
                              const Icon(
                                Icons.check_circle,
                                color: Color.fromARGB(255, 103, 241, 108),
                                size: 17,
                              )
                            ],
                          ),
            
                          Row(
                            children: [
                              Icon(
                                Icons.file_download_outlined,
                                color: Colors.pink.shade300,
                              ),
            
                              const SizedBox(width: 5,),
                              const Icon(
                                Icons.more_horiz,
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
    
                Divider(
                  color: Colors.grey.shade300,
                  thickness: 2,
                ),
    
                
              ],
            ),
          )),
    );
  }
}


> https://iosentrix.com/blog/understanding-log4j2-vulnerability-CVE-2021-44228/
> https://en.wikipedia.org/wiki/Log4Shell
> https://nakedsecurity.sophos.com/2021/12/13/log4shell-explained-how-it-works-why-you-need-to-know-and-how-to-fix-it/
> https://www.dynatrace.com/news/blog/what-is-log4shell/
> https://www.fortinet.com/resources/cyberglossary/cia-triad
> https://www.cybersecuritydive.com/news/security-development-devsecops/604636/



> only failed exploit attempts will be visible in the logs. If the exploit is successful and the payload is correctly interpreted by the JNDI handler, the payload will execute without making any entry in the logs. As such, a successful exploit will most probably be blind to log inspection.


I think Mr. Super Secure's assessment is not accurate. The first point is that, in the log files, only failed exploit attempts will be visible while the successful exploit will be invisible to log files. This is because the payload of a successful exploit is interpreted correctly by JNDI handler and then is executed without being recorded to log files. 

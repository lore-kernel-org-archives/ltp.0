From: Nikita Gupta <nikitarulz@gmail.com>
Date: Thu, 29 Mar 2018 16:42:12 +0530
Subject: [LTP] LTP-20170116: in6_01 fail
Message-ID: <CAGyGwR0MaMCZANJchFawPwDAv9cgX6DQ9a0D55xBFZEaduftaw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi All,
I am executing the LTP(20160126) tests for one of my board, and in it

Ipv6_lib is failing. below is the tests results and logs.

Test Start Time: Thu Jun 22 18:22:27 2017
-----------------------------------------
Testcase Result Exit Value
-------- ------ ----------
in6_01 FAIL 2
in6_02 PASS 0
getaddrinfo_01 PASS 0
asapi_01 PASS 0
asapi_02 PASS 0
asapi_03 PASS 0

-----------------------------------------------
Total Tests: 6
Total Skipped Tests: 0
Total Failures: 1

I did not find any failure reason in LTP bugs list for the same.
Attached is the log for in6_01 test case.

Kindly do let me know what configuration is making the test case fail.


-- 
Regards,
Nikita Gupta
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180329/58411592/attachment.html>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: in6_01.log
Type: text/x-log
Size: 4342 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180329/58411592/attachment.bin>

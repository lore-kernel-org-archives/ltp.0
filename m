From: Michael Kasprowicz <booomerangg@gmail.com>
Date: Thu, 21 Apr 2016 09:11:51 +0200
Subject: [LTP] fs test failure on quad core
Message-ID: <CAL+DEf0BCVUfdtK0wC9w-tfHAXaeJfhvPhfH6Q__5bjihh5B2A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Greetings everyone,
I am using ltp-full-20150903 to test some eMMCs on an Intel platform. I
slightly modify the script 'fs' and keep only iogen and rwtests. The tests
always results in I/O errors when I am using 4 cores, if I limit my system
to 2 cores the Test passes (no errors for over 6 hours). I have confirmed
this on at least 10 different types of eMMCs.
The errors are mostly I/O errors that appear after 5-10 minutes of running
the test mostly with test type iogen01. They consists of Buffer I/O errors
followed by interrupt timeouts and ADMA errors. After this point the eMMC
becomes useless i.e. cannot be read, written, mounted or unmounted till a
system reboot.

With the above results I can point my finger straight at the four cores and
the fact that several threads work simultaneously to generate the stress.
Are you aware of any particular parameter which one must set when running
the tests on quad core systems ? or has such an issue been previously
reported ?

best regards
michael
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160421/d57e03cf/attachment.html>

From: Abhishek Kumar Rai <abhishekr@eximiusdesign.com>
Date: Tue, 17 Jul 2018 19:35:34 +0530
Subject: [LTP] Facing issue while running lcov on nitrogen6x
Message-ID: <CALYWmf9_2ofnGZM52AORb2iT5Lf4vjjWBxW4-8nrY62qUowfZA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hii Team,

I am gettting following errors while running lcov with agl yocto
environment on nitrogen6x

{{{
    root@nitrogen6x:/sys/kernel/debug/gcov# lcov -c -b ~/ltp_agl/build/
-o
     /tmp/kernel.info
     Auto-detecting gcov kernel support.
     Found upstream gcov kernel support at /sys/kernel/debug/gcov
     Copying data to temporary directory /tmp/IJWGHXodVA
     Capturing coverage data from /tmp/IJWGHXodVA
     Found gcov version: 6.3.0
     Scanning /tmp/IJWGHXodVA for .gcda files ...
     Found 1881 data files in /tmp/IJWGHXodVA
     Processing linux-boundary/4.1.15-r0/build/lib/fonts/fonts.gcda
     geninfo: ERROR: ~/ltp_agl/build/tmp/work/nitrogen6x-agl-linux-gnueabi
      /linux-boundary/4.1.15-r0/build/lib/fonts/.tmp_fonts.gcno: could not
open
      file
}}}

please provide your input regarding this.

Regards,
Abhishek

-- 














The information contained in this e-mail message (including 
any 


attachments) may be confidential, proprietary, privileged, or 
otherwise


exempt from disclosure under applicable laws. It is intended to 
be 


conveyed only to the designated recipient(s). Any use, dissemination, 



distribution, printing, retaining or copying of this e-mail (including 
its 


attachments) by unintended recipient(s) is strictly prohibited and 
may 


be unlawful. If you are not an intended recipient of this e-mail, or 
believe 


that you have received this e-mail in error, please notify the 
sender 


immediately (by replying to this e-mail), delete any and all 
copies of 


this e-mail (including any attachments) from your system, and 
do not


disclose the content of this e-mail to any other person. Thank you 
for your cooperation.






-- 
_This e-mail message (including any attachments) may be confidential, 
proprietary, privileged, or otherwise exempt from disclosure under 
applicable laws. If you are not an intended recipient, please delete this 
message. Thank you.
_
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180717/08b9058d/attachment.html>

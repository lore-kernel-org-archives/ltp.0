From: Rajesh <rajeshkuri@gmail.com>
Date: Fri, 12 May 2017 20:32:36 +0530
Subject: [LTP] ltp-pan failing
Message-ID: <CALp+=PD4_zLu_ctpaZuTgWHsq3q90RKn_wYuBXS8c=-G+FYfQw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

I'm trying to run the LTP in embedded environment. (Having ramdisk as
files system and n/w shared directory for file storage)
The LTP version is ''ltp-full-20120401'' and ran simple command as below:
# ./ltp-pan -n exp1  -a /tmp/test -x 3 echo hello
And above command failed as:
"pan(exp1): failed to unlock zoo file, errno:9 Bad file descriptor"

Are there any specific configuration to run LTP in embedded environment?

-Regards,
rajesh

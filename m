From: Zhang, Yixin <yixin.zhang@intel.com>
Date: Tue, 15 May 2018 04:03:23 +0000
Subject: [LTP] A new API to get distro name?
Message-ID: <F8498D2F03F2CF40823E11B9D93AD69F3A4DB22C@SHSMSX101.ccr.corp.intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

I see that some shell tests are sensitive to distro, but not well managed currently. 
Here are some examples I find:
In test "su01" in scenario "admin_tools", here is the way how it determine the distro (which is incorrect)
  41 tvar=${MACHTYPE%-*}
  42 tvar=${tvar#*-}
  43
  44 # need to export tvar for su01_s1
  45 export tvar
  46 printf "Machine type is: $tvar\n\n"
  47
  48 if [ "$tvar" = "redhat" -o "$tvar" = "redhat-linux" ]
  49 # Need to also set group for TEST_USER2
Similar for cron/at tests in "admin_tools" (the location of deny/allow file is not at the default location for Ubuntu)

Also in test cpuhotplug07, the folder "/usr/src/linux" doesn't exits on Ubuntu, so some modification based on distro is needed.

I'd like to fix them, and need some suggestion: should we add a common API in test.sh or should I just fix them in the test cases derectly? If we plan to add a common API in the test.sh I may need some help as here I don't have all the distro in hand. Thanks. 

Yixin

From: Bharamshetti, Amar <Amar.Bharamshetti@cavium.com>
Date: Tue, 12 Sep 2017 09:08:04 +0000
Subject: [LTP] Running syscall getcpu01 on aarm64 architecture.
Message-ID: <CY4PR07MB2949527AF2E1AF449183CB3B83690@CY4PR07MB2949.namprd07.prod.outlook.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Dear all,

I have created patch for /kernel/syscalls/getcpu test case.

     Issues which I fixed and tested on kernel 4.10  :


  *   Currently test case checks if arch is _x86 or _i386 and skips the execution for other archs. Removing this conditional compilation to make it run on arm64 as well.

          -     Verified this on _86_64, aarch64 single node and aarch64 dual node systems. Works fine.

  *   Retrieving the correct node id for given cpu number. Currently its done for only _i386. Hence test suit fails for multiple node system other than _i386 arch machines.

          -    Verified this on _86_64, aarch64 single node and aarch64 dual node systems. Works fine.

  *   Removing unnecessary TCONF   "/sys not mounted or not a numa system. Assuming one node"  .

           -    Verified this on _86_64, aarch64 single node and aarch64 dual node systems. Works fine.


Please review the patch and let me know,  if I have missed anything or something is wrong.



Best Regards,

Amar


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170912/1adcc390/attachment-0001.html>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-Committer-Amar-Bharmshetti-amar.bharamshetti-cavium..patch
Type: text/x-patch
Size: 3208 bytes
Desc: 0001-Committer-Amar-Bharmshetti-amar.bharamshetti-cavium..patch
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170912/1adcc390/attachment-0001.bin>

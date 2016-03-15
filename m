From: Julio Cruz Barroso <julio.cruz@smartmatic.com>
Date: Tue, 15 Mar 2016 10:41:35 +0000
Subject: [LTP] getrusage03: check available memory to support embedded
	devices
Message-ID: <AF04265A3FC2B144B9892F621A394E13EA3E8950@tethys>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

This patch check the available memory before to perform the different test cases on "getrusage03". If the memory is not enough (according with each test case), the test finish as TCONF. This could be useful when you are testing on embedded devices with RAM memory limitation (i.e. 512MB) This patch no changed the test case procedure and is still valid  for non-embedded devices. It just check the available memory.

This patch come from previous discussion at http://lists.linux.it/pipermail/ltp/2016-March/001233.html

Regards

Julio
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160315/97b28fa7/attachment.html>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-Check-available-memory-to-support-embedded-devices.patch
Type: application/octet-stream
Size: 5490 bytes
Desc: 0001-Check-available-memory-to-support-embedded-devices.patch
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160315/97b28fa7/attachment.obj>

From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Fri, 3 Mar 2017 14:15:54 +0800
Subject: [LTP] [PATCH] syscalls/keyctl02: Add new regression test
In-Reply-To: <20170302141335.GB27525@rei.lan>
References: <1487644775-12365-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <20170302141335.GB27525@rei.lan>
Message-ID: <58B90A1A.7070509@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!

Thanks for your review.

On 03/02/2017 10:13 PM, Cyril Hrubis wrote:
> Hi!
>> Fixed by:
>> commit b4a1b4f5047e4f54e194681125c74c0aa64d637d
>> Author: David Howells <dhowells@redhat.com>
>> Date:   Fri Dec 18 01:34:26 2015 +0000
>>
>>     KEYS: Fix race between read and revoke
> 
> Looks good, the original reproducer uses four threads instead of two
> though. Are two enough to crash the buggy kernel with 100% probability?

Sorry, after a large number of tests, I find that current code cannot
ensure the reproducibility.

Using four threads with 20000 loops can crash the buggy kernel with
almost 100% probability. and it still only takes 1s to test.
I will send a V2, thanks.


Tested on following kernel:

Reproduced:
===================
RHEL7.2GA
v4.4-rc5-168-g73796d8(commit 73796d8)
===================

Not reproduced:
===================
RHEL7.3Alpha
v4.4-rc5-169-gb4a1b4f(commit b4a1b4f)
===================

Best Regards,
Guangwen Feng



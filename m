From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 17 May 2016 09:03:22 +0800
Subject: [LTP] [PATCH] syscalls/access01: Fix the test to run both under
 nobody and root
In-Reply-To: <20160516122326.GB6454@rei.lan>
References: <1463368789-1403-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20160516122326.GB6454@rei.lan>
Message-ID: <573A6DDA.1080802@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


> Hi!
> This is workaround rather than a complete solution.
>
> What I have in mind for the testcase is to add field to the test
> structure that describes if the particular testcase is expected to run
> under root or not. Then we can add a few testcases that tests that R and
> W flags are ignored for root.
>
Thanks for your suggestion.
I will rewrite this patch.

Regards,
Xiao Yang




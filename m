From: Steve Muckle <smuckle@google.com>
Date: Fri, 15 Feb 2019 17:21:56 -0800
Subject: [LTP] patch with recvmmsg/sendmmsg test cases
In-Reply-To: <f4cb5500-a3b7-144e-98dd-3faea58b4707@google.com>
References: <f4cb5500-a3b7-144e-98dd-3faea58b4707@google.com>
Message-ID: <b73de08f-2e37-5e3f-aaf5-ccdca6f8b07a@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Ramon,

On 02/14/2019 10:49 PM, Ramon Pantin wrote:
>  From 59d293fed8db662b3c252e1a063300a4a25bf969 Mon Sep 17 00:00:00 2001
> From: Ramon Pantin<pantin@google.com>
> Date: Thu, 14 Feb 2019 22:36:04 -0800
> Subject: [PATCH] Tests for sendmmsg/recvmmsg, it also contains a bunch of
>   tests not covered by the existing test sendmsg/recvmsg tests cases. Not going
>   to separate those into independent tests because they are used in the
>   multiple-message syscall tests to form a variety of multi-message test cases.

Let's discuss offline before further upstream review.

thanks,
Steve

From: Cedric Hnyda <chnyda@suse.com>
Date: Fri, 30 Oct 2015 10:17:11 +0100
Subject: [LTP] [PATCH 3/3] diotest5.c: replaced iovec
In-Reply-To: <1912499711.38973678.1446195193937.JavaMail.zimbra@redhat.com>
References: <1446137758-27267-1-git-send-email-chnyda@suse.com>
 <1446137758-27267-3-git-send-email-chnyda@suse.com>
 <1912499711.38973678.1446195193937.JavaMail.zimbra@redhat.com>
Message-ID: <56333597.1060600@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 10/30/2015 09:53 AM, Jan Stancek wrote:
> What is the problem with iovecs here?
> Isn't readv/writev meant to be used in this test?
>
>   * DESCRIPTION
>   *      The programs test buffered and direct IO with vector arrays using
>   *      readv() and writev() calls.

My bad. You are right it is indeed irrelevant.
I misread something.

Best,
Cedric

-- 
Cedric Hnyda


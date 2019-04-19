From: Eric Biggers <ebiggers@kernel.org>
Date: Fri, 19 Apr 2019 10:11:17 -0700
Subject: [LTP] crypto test af_alg04.c crash the LPAR
In-Reply-To: <OFC91206F0.EB621360-ON002583E1.004ACB92-002583E1.004B8DDC@notes.na.collabserv.com>
References: <OFC91206F0.EB621360-ON002583E1.004ACB92-002583E1.004B8DDC@notes.na.collabserv.com>
Message-ID: <20190419171116.GA183327@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Is this test doing an intentional crash? When it is run on RHEL8.0 latest
> kernel, it immediately crashes the LPAR

Do not send HTML email, people will usually ignore it...

But yes, the test is testing for a bug that caused a kernel crash, so your
kernel has that bug.  That's the whole point of the test; see the comment at the
top of the file.

In general if anything userspace does crashes the kernel, it's a kernel bug.

- Eric

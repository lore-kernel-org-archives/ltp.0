From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 10 Nov 2017 06:21:04 -0500 (EST)
Subject: [LTP] [PATCH 5/6] syscalls/mkdir03: convert to new API and use
 .needsrofs for EROFS check
In-Reply-To: <20171109003438.130802-6-sspatil@google.com>
References: <20171109003438.130802-1-sspatil@google.com>
 <20171109003438.130802-6-sspatil@google.com>
Message-ID: <320554694.38835277.1510312864075.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it




----- Original Message -----
> The mkdir03 test is converted to the new API along with removing the
> need to manually acquire and mount a loopback devices for EROFS checks.
> This now makes it possible for the test to run on Android systems as
> well.
> 
> Signed-off-by: Sandeep Patil <sspatil@google.com>

Pushed with 2 small changes:
- drop UCLINUX support
- keep the setupfunc, so that we don't hardcode indexes into tcase array

Thanks,
Jan

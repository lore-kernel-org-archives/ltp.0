From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 17 Jul 2018 07:08:10 -0400 (EDT)
Subject: [LTP] [PATCH v2] quota_remount_test01: Add explicit check for
 dependencies
In-Reply-To: <20180717110144.28118-1-punit.agrawal@arm.com>
References: <20180717110144.28118-1-punit.agrawal@arm.com>
Message-ID: <643712395.33511391.1531825690463.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> quota_remount_test01 doesn't check for dependencies before
> execution. Add explicit checks for quotacheck and quotaon and bail out
> if they are not present.
> 
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> ---
> v2:
> * Replaced the use of test.sh with shell commands to check for test
>   dependencies

Pushed.

Thanks,
Jan

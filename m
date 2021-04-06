From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 6 Apr 2021 16:43:52 +0200
Subject: [LTP] [PATCH] security/prot_hsymlinks: Set umask before mkdir
In-Reply-To: <20210401135638.4111-1-zhaogongyi@huawei.com>
References: <20210401135638.4111-1-zhaogongyi@huawei.com>
Message-ID: <YGxzqO9HxYi2Jo4z@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> When uid is nobody, umask is 0077, the test process might has
it's actually hsym user.
> not permmission to access the file which created by SAFE_MKDIR
(permission)
> with mode 0755.

Thanks for your fix!
Merged with comment in the code. BTW I guess we might want to add this umask
to SAFE_MKDIR() instead of fixing all tests which are affected by 0077.

Kind regards,
Petr

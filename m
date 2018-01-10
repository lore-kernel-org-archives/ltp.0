From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Wed, 10 Jan 2018 10:42:53 +0100
Subject: [LTP] [PATCH v2 2/2] syscalls/request_key04: new test for
	request_key() permission check bug
In-Reply-To: <20180109220846.211823-2-ebiggers3@gmail.com>
References: <20180109220846.211823-1-ebiggers3@gmail.com>
 <20180109220846.211823-2-ebiggers3@gmail.com>
Message-ID: <87vagajbhe.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Eric,

Eric Biggers writes:

> From: Eric Biggers <ebiggers@google.com>
>
> Add a test for a bug that allowed the request_key() system call to be
> used to add a key to a keyring using only Search permission.  This bug
> was assigned CVE-2017-17807.
>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>
> No changes since v1, just added a patch preceding this one.
>
>  include/lapi/keyctl.h                              |  4 +
>  runtest/cve                                        |  1 +
>  runtest/syscalls                                   |  1 +
>  .../kernel/syscalls/request_key/request_key04.c    | 87 ++++++++++++++++++++++
>  4 files changed, 93 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/request_key/request_key04.c

Only issue is that you are missing .gitignore entry. Otherwise LGTM.

-- 
Thank you,
Richard.

From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 10 Jan 2018 12:12:30 +0100
Subject: [LTP] [PATCH v2 2/2] syscalls/request_key04: new test for
 request_key() permission check bug
In-Reply-To: <20180109220846.211823-2-ebiggers3@gmail.com>
References: <20180109220846.211823-1-ebiggers3@gmail.com>
 <20180109220846.211823-2-ebiggers3@gmail.com>
Message-ID: <20180110111229.msrsio6z4d2o4pf4@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> From: Eric Biggers <ebiggers@google.com>

> Add a test for a bug that allowed the request_key() system call to be
> used to add a key to a keyring using only Search permission.  This bug
> was assigned CVE-2017-17807.

> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---

LGTM both commits.
BTW it might be worth to define SAFE_KEYCTL().


Kind regards,
Petr

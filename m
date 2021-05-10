From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 10 May 2021 19:28:12 +0200
Subject: [LTP] [PATCH v4 1/3] ima_keys.sh: Check policy only once
In-Reply-To: <f22e507d-1983-b7a0-b5e0-15e1519ca038@linux.microsoft.com>
References: <20210507191414.14795-1-pvorel@suse.cz>
 <20210507191414.14795-2-pvorel@suse.cz>
 <f22e507d-1983-b7a0-b5e0-15e1519ca038@linux.microsoft.com>
Message-ID: <YJltLKrpw0O4MtCU@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi all,

> On 5/7/21 12:14 PM, Petr Vorel wrote:
> > Not needed to check the same policy twice.
> > Rename to contain 'require' as we use tst_brk.

> Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

Thanks Lakshmi, merged this one.

And waiting for the other two till Tushar manage to get
the dm-crypt related code to mainline. Good luck!

Kind regards,
Petr

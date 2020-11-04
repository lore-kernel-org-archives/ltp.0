From: Radoslav Kolev <radoslav.kolev@suse.com>
Date: Wed, 4 Nov 2020 11:34:08 +0000
Subject: [LTP] [PATCH v2 05/11] syscalls: Add a few documentation
 comments
In-Reply-To: <20201103191327.11081-6-pvorel@suse.cz>
References: <20201103191327.11081-1-pvorel@suse.cz>
 <20201103191327.11081-6-pvorel@suse.cz>
Message-ID: <d0e937e67108585af4423e9f688941cb194476ba.camel@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Petr,

On Tue, 2020-11-03 at 20:13 +0100, Petr Vorel wrote:
> 
> + * [DESCRIPTION]
> + *  Checks that process which called abort() gets killed by SIGIOT
> and dumps core.

...

> +/*\
> + * [DOCUMENTATION]
> + *  Verify that acct() returns proper errno on failure.
> +\*/
> +

I noticed that in some places the DESCRIPTION tag is used and in
another DOCUMENTATION. What is the difference between the two and which
should be used when?

Regards,
Rado

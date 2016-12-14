From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 14 Dec 2016 18:06:04 +0100
Subject: [LTP] [PATCH 1/1] network/echoes: fix endless loop on error
In-Reply-To: <5846989A.2020104@oracle.com>
References: <20161129160259.31058-1-pvorel@suse.cz>
 <5846989A.2020104@oracle.com>
Message-ID: <20161214170604.nycf5yipmdvcyss7@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> Good catch, looks like we could substitute the while loop here with
> tst_reap_children() library function and remove "echo_struc" as well?
Could you please push this quick fix? I plan to rewrite test into new API, but probably
will not manage it until the release.

Kind regards,
Petr
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20161214/fc9d9bdd/attachment.sig>

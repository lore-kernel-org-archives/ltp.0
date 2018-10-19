From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 19 Oct 2018 07:38:22 +0200
Subject: [LTP] [PATCH v2 1/1] net: Fix missing ping6
In-Reply-To: <61a9206d-2af4-396a-44dc-ecff4f4ce27f@oracle.com>
References: <20181018144211.8298-1-pvorel@suse.cz>
 <61a9206d-2af4-396a-44dc-ecff4f4ce27f@oracle.com>
Message-ID: <20181019053822.GA19290@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> > +if ! tst_cmd_available ping6; then
> > +	ping6()
> > +	{

> What about printing the message on the first usage only?

>                 if [ -z "$ping6_warn_printed" ]; then
>                         tst_res_ TINFO "ping6 ..."
>                         ping6_warn_printed=yes
Make sense. Added with export (required to be working properly).

> The rest looks good.
Applied with your ack-by and suggested-by

Thanks for your comments!


Kind regards,
Petr

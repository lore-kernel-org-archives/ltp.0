From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 24 Aug 2020 17:48:12 +0200
Subject: [LTP] [PATCH v2 1/1] prepare_lvm.sh: Allow to define tmp
 directory
In-Reply-To: <648dc99d-5079-23ec-eba2-b10215ae8130@suse.cz>
References: <20200824112109.2995-1-pvorel@suse.cz>
 <648dc99d-5079-23ec-eba2-b10215ae8130@suse.cz>
Message-ID: <20200824154812.GA4330@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

...
> > -			sed -e "s/{fsname}/$fsname/g" "$INFILE" >>"$OUTFILE"
> > +			sed -e "s/{fsname}/$fsname/g; s^/tmp/ltp^$LVM_DIR/ltp^g" "$INFILE" >>"$OUTFILE"

> If you want to change the path in the runfile instead, it'd be cleaner
> to use a placeholder like {tempdir}. Otherwise:
That makes sense, changed that way and merged with your ack.
Thanks a lot for review and comments.

Kind regards,
Petr

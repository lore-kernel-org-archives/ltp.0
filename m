From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 29 Mar 2018 08:18:16 +0200
Subject: [LTP] [RFC PATCH v2 3/4] ima/ima_boot_aggregate: Increase
 MAX_EVENT_SIZE to 8k
In-Reply-To: <OF557260E5.C2BA817A-ON8625825D.007ABFC1-8625825D.007AFB67@notes.na.collabserv.com>
References: <20180314155731.5943-1-pvorel@suse.cz>
 <20180314155731.5943-4-pvorel@suse.cz>
 <1522179855.3541.191.camel@linux.vnet.ibm.com>
 <OF557260E5.C2BA817A-ON8625825D.007ABFC1-8625825D.007AFB67@notes.na.collabserv.com>
Message-ID: <20180329061816.GB31604@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

Hi George,

> > Is there a way of making this value system dependent? =C2=A0On my
> > laptop this is fine, but for PowerVM w/TPM 1.2 I've been told this is
> > too small.

> Why not follow the spec?  PowerVM has enormous events because they
> were allowed by the 1.2 spec.  The 2.0 spec recommends 1M so I think
> they should be at least 1M.  Because they're large, they should really
> be dynamically allocated.
Make sense. Lets try 1M.
Thanks a lot for your input.


Kind regards,
Petr

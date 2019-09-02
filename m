From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 2 Sep 2019 16:05:32 +0200
Subject: [LTP] [PATCH v4 2/4] BPF: Sanity check creating and updating
 maps
In-Reply-To: <456316863.8154593.1566823938723.JavaMail.zimbra@redhat.com>
References: <20190826111024.19053-1-chrubis@suse.cz>
 <20190826111024.19053-3-chrubis@suse.cz>
 <456316863.8154593.1566823938723.JavaMail.zimbra@redhat.com>
Message-ID: <20190902140531.GA10860@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Small nit (maybe personal preference), I'd rather make this check for
> map_types.attr, as opposed to test number / some position in array.

Sounds good.

> > +	case 0:
> > +		if (TST_RET != -1 || TST_ERR != ENOENT) {
> > +			tst_res(TFAIL | TTERRNO,
> > +				"Empty hash map lookup should fail with ENOENT");
> > +		} else {
> > +			tst_res(TPASS | TTERRNO, "Empty hash map lookup");
> > +		}
> > +	break;
> > +	case 1:
> > +		if (TST_RET != -1) {
> > +			for (i = 0;;) {
> > +				if (val_get[i] != 0) {
> > +					tst_res(TFAIL,
> > +						"Preallocated array map val not zero");
> 
> If we hit this TFAIL, will the loop terminate?

My bad, I will change this to use proper for() loop.

-- 
Cyril Hrubis
chrubis@suse.cz

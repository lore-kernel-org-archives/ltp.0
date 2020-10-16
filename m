From: Michal =?unknown-8bit?q?Koutn=C3=BD?= <mkoutny@suse.com>
Date: Fri, 16 Oct 2020 19:26:35 +0200
Subject: [LTP] [RFC PATCH] mm: memcg/slab: Stop reparented obj_cgroups
 from charging root
In-Reply-To: <87pn5irz2m.fsf@suse.de>
References: <20201014190749.24607-1-rpalethorpe@suse.com>
 <20201016094702.GA95052@blackbook> <87sgaesba0.fsf@suse.de>
 <87pn5irz2m.fsf@suse.de>
Message-ID: <20201016172635.GB102311@blackbook>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Oct 16, 2020 at 04:05:21PM +0100, Richard Palethorpe <rpalethorpe@suse.de> wrote:
> I'm don't know if that could happen without reparenting. I suppose if
> use_hierarchy=1 then actually this patch will result in root being
> overcharged, so perhaps it should also check for use_hierarchy?
Right, you'd need to distinguish whether the uncharged objcg was
originally (not)charged in the root memcg or it was only reparented to
it. (I originally considered only the genuine root objcgs.)

In this light, homogenous charing to root memcg looks really simpler but
I wonder what other surprises it brings about.

Michal
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: Digital signature
URL: <http://lists.linux.it/pipermail/ltp/attachments/20201016/4bdadf77/attachment-0001.sig>

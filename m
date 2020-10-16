From: Michal =?unknown-8bit?q?Koutn=C3=BD?= <mkoutny@suse.com>
Date: Fri, 16 Oct 2020 11:47:02 +0200
Subject: [LTP] [RFC PATCH] mm: memcg/slab: Stop reparented obj_cgroups
 from charging root
In-Reply-To: <20201014190749.24607-1-rpalethorpe@suse.com>
References: <20201014190749.24607-1-rpalethorpe@suse.com>
Message-ID: <20201016094702.GA95052@blackbook>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello.

On Wed, Oct 14, 2020 at 08:07:49PM +0100, Richard Palethorpe <rpalethorpe@suse.com> wrote:
> SLAB objects which outlive their memcg are moved to their parent
> memcg where they may be uncharged. However if they are moved to the
> root memcg, uncharging will result in negative page counter values as
> root has no page counters.
Why do you think those are reparented objects? If those are originally
charged in a non-root cgroup, then the charge value should be propagated up the
hierarchy, including root memcg, so if they're later uncharged in root
after reparenting, it should still break even. (Or did I miss some stock
imbalance?)

(But the patch seems justifiable to me as objects (not)charged directly to
root memcg may be incorrectly uncharged.)

Thanks,
Michal
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: Digital signature
URL: <http://lists.linux.it/pipermail/ltp/attachments/20201016/f8747070/attachment.sig>

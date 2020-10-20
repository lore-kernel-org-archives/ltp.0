From: Michal =?unknown-8bit?q?Koutn=C3=BD?= <mkoutny@suse.com>
Date: Tue, 20 Oct 2020 19:24:02 +0200
Subject: [LTP] [PATCH v3] mm: memcg/slab: Stop reparented obj_cgroups
 from charging root
In-Reply-To: <87mu0hwik7.fsf@suse.de>
References: <87lfg2ob83.fsf@suse.de>
 <20201019095812.25710-1-rpalethorpe@suse.com>
 <CALvZod6FNH3cZfZxLSFXtQR5bV_2Tese0793Ve9rd1YNW22MKg@mail.gmail.com>
 <87mu0hwik7.fsf@suse.de>
Message-ID: <20201020172402.GD46039@blackbook>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi.

On Tue, Oct 20, 2020 at 06:52:08AM +0100, Richard Palethorpe <rpalethorpe@suse.de> wrote:
> I don't think that is relevant as we get the memcg from objcg->memcg
> which is set during reparenting. I suppose however, we can determine if
> the objcg was reparented by inspecting memcg->objcg.
+1

> If we just check use_hierarchy then objects directly charged to the
> memcg where use_hierarchy=0 will not be uncharged. However, maybe it is
> better to check if it was reparented and if use_hierarchy=0.
I think (I had to make a table) the yielded condition would be:

if ((memcg->use_hierarchy && reparented) || (!mem_cgroup_is_root(memcg) && !reparented))
	 __memcg_kmem_uncharge(memcg, nr_pages);

(I admit it's not very readable.)


Michal
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: Digital signature
URL: <http://lists.linux.it/pipermail/ltp/attachments/20201020/e1aefbf7/attachment.sig>

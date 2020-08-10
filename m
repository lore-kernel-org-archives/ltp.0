From: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 10 Aug 2020 10:31:53 +0200
Subject: [LTP] [PATCH] Drop the mem01 test
In-Reply-To: <752669298.7180757.1597047872449.JavaMail.zimbra@redhat.com>
References: <20200806162356.16920-1-mdoucha@suse.cz>
 <752669298.7180757.1597047872449.JavaMail.zimbra@redhat.com>
Message-ID: <7878432a-14f8-a4c4-a4fe-09e77c79f27d@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 10. 08. 20 10:24, Jan Stancek wrote:
> I'm fine with dropping it. Just curious, how is it failing? Do you see it
> hit TFAIL, OOM or something else?

It's getting killed by OOM. The test leaves a hard-coded safety margin
of 16MB unallocated. That's 4096 pages on x86_64 but only 256 pages on
PPC. Making the safety margin pagesize-dependent would be the obvious
fix if we wanted to keep the test.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

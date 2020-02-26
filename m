From: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 26 Feb 2020 17:40:35 +0100
Subject: [LTP] [PATCH v5] Add test for misaligned fallocate()
In-Reply-To: <20200226135748.GD24080@rei>
References: <20200224100932.10349-1-mdoucha@suse.cz>
 <20200226135748.GD24080@rei>
Message-ID: <0d875613-07a4-b9fe-9c83-76c2e403d6dc@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2/26/20 2:57 PM, Cyril Hrubis wrote:
> Hi!
> Are the failures on xfs fixed by now?
> 
> Do we have a upstrem kernel commit we can add to the test as a tag?
> 

Anthony Iliopoulos says in the BSC that the upstream fix is
commit e093c4be760e ("xfs: Fix tail rounding in xfs_alloc_file_space()")

See https://bugzilla.suse.com/show_bug.cgi?id=1161087#c1

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

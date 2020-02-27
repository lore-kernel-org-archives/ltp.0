From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 27 Feb 2020 15:13:56 +0100
Subject: [LTP] [PATCH v5] Add test for misaligned fallocate()
In-Reply-To: <0d875613-07a4-b9fe-9c83-76c2e403d6dc@suse.cz>
References: <20200224100932.10349-1-mdoucha@suse.cz>
 <20200226135748.GD24080@rei>
 <0d875613-07a4-b9fe-9c83-76c2e403d6dc@suse.cz>
Message-ID: <20200227141356.GA29089@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Are the failures on xfs fixed by now?
> > 
> > Do we have a upstrem kernel commit we can add to the test as a tag?
> > 
> 
> Anthony Iliopoulos says in the BSC that the upstream fix is
> commit e093c4be760e ("xfs: Fix tail rounding in xfs_alloc_file_space()")

I've added this as a tag and commend and also added a .gitignore entry
and pushed. Thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

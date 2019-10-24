From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 24 Oct 2019 14:26:10 +0200
Subject: [LTP] [RFC PATCH] Delete New ext4 features tests and ffsb tool
In-Reply-To: <20191024110502.GA27782@rei.lan>
References: <20191024090753.16789-1-pvorel@suse.cz>
 <20191024110502.GA27782@rei.lan>
Message-ID: <20191024122610.GA7865@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Hi!
> > The main reason is that these tests [1] (contributed in 2009)
> > are mostly outdated and irrelevant. According to Theodore Y. Tso [2]
> > and Jan Kara [3] the only partly valid tests are
> > ext4_nsec_timestamps_test.sh and ext4_subdir_limit_test.sh,
> > but even these would be better to migrate to xfstests,
> > which Yong Sun is planning to do.

> > Also, some of the tests weren't in any runtest file anyway
> > (ext4-alloc-test.sh, ext4_inode_version_test.sh,
> > ext4_journal_checksum.sh, ext4_online_defrag_test.sh)

> > ffsb tool was used only in these New ext4 features tests.

> > [1] http://ext4.wiki.kernel.org/index.php/New_ext4_features
> > [2] https://marc.info/?l=linux-fsdevel&m=157187153211649&w=2
> > [3] https://marc.info/?l=linux-ext4&m=157190318618555&w=2

> > Closes: #560

> Acked.

> The ffsb adds quite a bit of complexity to the LTP build with a very
> little added value. As far as the meaningful parts of the ext4 suite
> would be migrated to xfstests everyone should be happy about this.
Thanks for ack, merged.

Kind regards,
Petr

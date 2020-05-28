From: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 28 May 2020 13:39:43 +0200
Subject: [LTP] [RFC PATCH 1/2] LVM: Don't require root for
 generate_lvm_runfile.sh
In-Reply-To: <20200528110554.10179-2-pvorel@suse.cz>
References: <20200528110554.10179-1-pvorel@suse.cz>
 <20200528110554.10179-2-pvorel@suse.cz>
Message-ID: <858875ff-2137-38b6-8301-f44e745f8026@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 28. 05. 20 13:05, Petr Vorel wrote:
> LTPROOT can be in user writable directory. Having rights for make
> install is user responsibility, it does not have to be guarded by
> TST_NEEDS_ROOT=1.

TST_NEEDS_ROOT=1 is there for tst_supported_fs. It won't find any mkfs
programs if it's not running as root.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

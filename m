From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 14 Apr 2020 15:05:59 +0200
Subject: [LTP] [PATCH v5 2/3] Add LVM support scripts
In-Reply-To: <45d1cdc4-0a15-e987-b88d-87624215019b@suse.cz>
References: <20200414085934.8840-1-mdoucha@suse.cz>
 <20200414085934.8840-2-mdoucha@suse.cz>
 <20200414122908.GA6700@yuki.lan>
 <45d1cdc4-0a15-e987-b88d-87624215019b@suse.cz>
Message-ID: <20200414130559.GB6700@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Jo!
> >> diff --git a/testcases/misc/lvm/generate_lvm_runfile.sh b/testcases/misc/lvm/generate_lvm_runfile.sh
> > 
> > Hmm, where exactly is this called?
> > 
> > How is the template used?
> 
> generate_lvm_runfile.sh will be called near the end of install_ltp to
> generate system-specific runfile for LVM tests using the template.
> prepare_lvm.sh will be called in a separate OpenQA module right after
> boot_ltp. None of these helper scripts should be included in any runfile.

So these are OpenQA specific scripts, I do not think that they belong to
LTP upstream unless we make then work with upstream LTP.

-- 
Cyril Hrubis
chrubis@suse.cz

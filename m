From: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 14 Apr 2020 15:49:26 +0200
Subject: [LTP] [PATCH v5 2/3] Add LVM support scripts
In-Reply-To: <20200414130559.GB6700@yuki.lan>
References: <20200414085934.8840-1-mdoucha@suse.cz>
 <20200414085934.8840-2-mdoucha@suse.cz> <20200414122908.GA6700@yuki.lan>
 <45d1cdc4-0a15-e987-b88d-87624215019b@suse.cz>
 <20200414130559.GB6700@yuki.lan>
Message-ID: <1a9956bc-f6b8-f360-e8c8-14fa59bee91b@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 14. 04. 20 15:05, Cyril Hrubis wrote:
>> generate_lvm_runfile.sh will be called near the end of install_ltp to
>> generate system-specific runfile for LVM tests using the template.
>> prepare_lvm.sh will be called in a separate OpenQA module right after
>> boot_ltp. None of these helper scripts should be included in any runfile.
> 
> So these are OpenQA specific scripts, I do not think that they belong to
> LTP upstream unless we make then work with upstream LTP.

These scripts have no dependencies on OpenQA and can be used to prepare
LVM test environment under any harness, including manual testing. I've
made some design choices to ensure compatibility with OpenQA but they're
really meant as full replacement for testscripts/ltpfslvm.sh which has
been in LTP since forever.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

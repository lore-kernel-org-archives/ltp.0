From: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 6 Nov 2019 14:37:19 +0100
Subject: [LTP] [PATCH 1/1] Create full path to workdir in
 fs/doio/growfiles.c
In-Reply-To: <20191106125743.29952-2-mdoucha@suse.cz>
References: <20191106125743.29952-1-mdoucha@suse.cz>
 <20191106125743.29952-2-mdoucha@suse.cz>
Message-ID: <07eb77e5-6e5f-ed67-09a8-d3ccec455112@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Sorry, ignore my patch for growfiles.c, just creating the missing
directories is not the right setup for the LVM tests. The correct fix is
to rewrite testscripts/ltpfslvm.sh a bit and create an OpenQA module for
it that'll produce a VM snapshot (similar to create_junkfile_ltp that's
used for AIODIO tests).

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

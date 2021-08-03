From: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 3 Aug 2021 10:59:53 +0200
Subject: [LTP] [PATCH v2 2/2] Add setsockopt08, CVE-2021-22555
In-Reply-To: <20210803083836.8612-2-rpalethorpe@suse.com>
References: <20210803070520.30885-1-rpalethorpe@suse.com>
 <20210803083836.8612-1-rpalethorpe@suse.com>
 <20210803083836.8612-2-rpalethorpe@suse.com>
Message-ID: <731330a9-f374-2908-538e-3bb115897ab0@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
since this vulnerability is in the compat syscall wrappers, you should
also copy the arch bits check from setsockopt03 setup().

On 03. 08. 21 10:38, Richard Palethorpe via ltp wrote:
> This is a copy and paste of Nicolai's reproducer. The main difference
> is that I moved some code around. Of course I also used LTP library
> features, but essentially it works the same.
> 
> There are some hard coded values which I do not like. I guess these
> could be calculated or varied somehow. However I struggle to understand
> what the kernel is doing. This perhaps needs more investigation. We
> could try generalising this test and setsockopt03

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

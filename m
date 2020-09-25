From: Martin Doucha <mdoucha@suse.cz>
Date: Fri, 25 Sep 2020 12:31:06 +0200
Subject: [LTP] [PATCH] Fix search for device ID in tst_find_backing_dev()
In-Reply-To: <20200925102724.25815-1-mdoucha@suse.cz>
References: <20200925102724.25815-1-mdoucha@suse.cz>
Message-ID: <88b747e2-1d24-798e-6d71-bfc4cd483208@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 25. 09. 20 12:27, Martin Doucha wrote:
> The current search using substrings can lead to false positives, e.g. search
> for device 0:5 could return device 10:50 instead. Parse device IDs in
> /proc/self/mountinfo properly using sscanf() and also check whether the device
> was really found.
> 
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>

I forgot to add an extra comment that I still don't like that the search
uses fixed-size buffer without properly handling lines that are too long
but let's keep the fix simple for now. We can fix long line handling
after the release.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 18 May 2021 10:18:17 +0200
Subject: [LTP] [RFC PATCH 6/6] API: Check exported symbols
In-Reply-To: <20210517163029.22974-7-rpalethorpe@suse.com>
References: <20210517163029.22974-1-rpalethorpe@suse.com>
 <20210517163029.22974-7-rpalethorpe@suse.com>
Message-ID: <YKN4SZcHP9GAGRH4@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richie,

> Abort the build process if a new symbol is exported from the library
> without tst_ or safe_ prepended.

The PR does not work few on old toolchains [1], it fails on [2]:

awk: line 1: regular expression /parse_opts ... exceeds implementation size limit

It's one of the 2 awk calls in check_export_syms.sh, I suppose the other one.
Maybe put non_prefix_syms into temporary file and then run awk on it?

Kind regards,
Petr

[1] https://travis-ci.org/github/pevik/ltp/builds/771465129
[2] https://travis-ci.org/github/pevik/ltp/jobs/771465135#L3115

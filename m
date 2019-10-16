From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 16 Oct 2019 16:46:24 +0200
Subject: [LTP] [PATCH 1/2] lib: Add support for test tags
In-Reply-To: <20191016133039.GA6842@dell5510>
References: <20191014112522.24548-1-chrubis@suse.cz>
 <20191014112522.24548-2-chrubis@suse.cz>
 <20191016133039.GA6842@dell5510>
Message-ID: <20191016144624.GB19517@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +	if (tags) {
> > +		for (i = 0; tags[i].name; i++) {
> > +			if (!strcmp(tags[i].name, "CVE"))
> > +				printf(CVE_DB_URL "%s\n", tags[i].value);
> > +			else if (!strcmp(tags[i].name, "linux-git"))
> Not sure if it's worth of defining some enums instead of "CVE", "linux-git"
> (would catch typos).

I wanted to avoid enums because they are not flexible enough. The plan
here is that docparse would do sanity checks on test metadata and fail
the compilation if it founds typos there. With the checks in the
docparse tool we can easily check for tags that looks like typos, i.e.
check the levenshtein distance from all known tags and print a nice
looking error message...

-- 
Cyril Hrubis
chrubis@suse.cz

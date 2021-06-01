From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 1 Jun 2021 11:16:37 +0200
Subject: [LTP] [PATCH 3/3] CI: Move from Travis to GitHub Actions
In-Reply-To: <20210531165052.8731-4-pvorel@suse.cz>
References: <20210531165052.8731-1-pvorel@suse.cz>
 <20210531165052.8731-4-pvorel@suse.cz>
Message-ID: <YLX69YxFykMahpoB@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Travis is unreliable due "pull rate limit" issue.
> 
> Also using GitHub native CI allows more advanced features
> (e.g. update wiki with doc/*.txt, nightly build docparser doc).
> 
> Nice bonus is that manual podman activation for distros using glibc >=
> 2.33 (e.g. openSUSE Tumbleweed, Fedora) it's not needed in GitHub.
> 
> Fixes: https://github.com/linux-test-project/ltp/issues/761

Good work, thanks for doing this, acked.

Also please do not forget to remove the travis user from LTP github repo
once this is applied.

-- 
Cyril Hrubis
chrubis@suse.cz

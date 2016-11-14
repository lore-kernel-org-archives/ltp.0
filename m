From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 14 Nov 2016 14:12:17 +0100
Subject: [LTP] new shell library
In-Reply-To: <827120068.2432301.1477908222614.JavaMail.zimbra@redhat.com>
References: <20161003145835.GD7583@rei.suse.cz>
 <254451816.211402.1475574875165.JavaMail.zimbra@redhat.com>
 <20161012100806.GA24231@rei.lan>
 <1175646125.448517.1476268354007.JavaMail.zimbra@redhat.com>
 <20161012123602.GB24231@rei.lan> <20161012131726.GC24231@rei.lan>
 <1527497475.514457.1476284084454.JavaMail.zimbra@redhat.com>
 <20161027145806.GA25043@rei.lan>
 <827120068.2432301.1477908222614.JavaMail.zimbra@redhat.com>
Message-ID: <20161114131216.GB25055@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've added a few patches that remove tst_kvercmp in favor of tst_kvcmp
into the repository[1]. These are more or less trivial, the rest of the
patchset is the same, I only converted one more test (ar01) and keep
fixing conflicts so that it could be applied on the top of the latest
git tree.

Has anybody any feedback that would stop the inclusion of these patches?

If not I would like to get them into the git once I test that these
testcases can run fine from an installed tree so that we have enough
time to test the changes out before the next release.

[1] https://github.com/metan-ucw/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

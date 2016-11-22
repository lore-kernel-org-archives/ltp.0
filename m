From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 22 Nov 2016 12:21:49 +0100
Subject: [LTP] new shell library
In-Reply-To: <118984060.1453340.1479811659429.JavaMail.zimbra@redhat.com>
References: <20161003145835.GD7583@rei.suse.cz>
 <1527497475.514457.1476284084454.JavaMail.zimbra@redhat.com>
 <20161027145806.GA25043@rei.lan>
 <827120068.2432301.1477908222614.JavaMail.zimbra@redhat.com>
 <20161114131216.GB25055@rei.lan> <20161122065033.GA5620@rei.lan>
 <1438742745.1396390.1479801272456.JavaMail.zimbra@redhat.com>
 <20161122080252.GD5620@rei.lan>
 <118984060.1453340.1479811659429.JavaMail.zimbra@redhat.com>
Message-ID: <20161122112148.GA8038@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Looks good. Only thing that failed was 'file' test on older distros,
> because output of 'file' is slightly different for certain file types.

Hmm, I've seen that as well and fixed a few occurences.

Should we fix that before the patchset gets merged or will you fix that
afterwards in a follow up patch?

-- 
Cyril Hrubis
chrubis@suse.cz

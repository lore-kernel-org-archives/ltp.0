From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 16 Jan 2017 16:31:19 +0100
Subject: [LTP] LTP release status
In-Reply-To: <20170116152532.GJ1859@eguan.usersys.redhat.com>
References: <20170112142828.GC1208@rei.lan>
 <1124039564.1917107.1484233086635.JavaMail.zimbra@redhat.com>
 <20170112153917.GB5381@rei.lan>
 <1054431302.3375878.1484571069128.JavaMail.zimbra@redhat.com>
 <20170116130237.GA26610@rei.lan>
 <1116838376.3405880.1484572780617.JavaMail.zimbra@redhat.com>
 <20170116133023.GB26610@rei.lan>
 <329006128.105238.1484575796946.JavaMail.zimbra@redhat.com>
 <20170116152532.GJ1859@eguan.usersys.redhat.com>
Message-ID: <20170116153118.GA27333@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> OTOH, utimensat(2) manpage seems inconsistent/vague on immutable inode,

Read it once more, there are exact conditions specified where EACCES and
where EPERM should be returned.

-- 
Cyril Hrubis
chrubis@suse.cz

Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XHwEr-00032f-1u
	for ltp-list@lists.sourceforge.net; Thu, 14 Aug 2014 14:42:49 +0000
Date: Thu, 14 Aug 2014 16:41:52 +0200
From: chrubis@suse.cz
Message-ID: <20140814144152.GA29561@rei.suse.de>
References: <618b542aea7f9084ee9a725572a35cbd2b8e4142.1406030190.git.jstancek@redhat.com>
	<20140814135421.GA25594@rei.suse.de>
	<1070857162.7225595.1408026186525.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1070857162.7225595.1408026186525.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH] syslog-lib: add SystemLogSocketName to
	rsyslog.conf
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > I've read this twice and I'm still unsure what happens.
> > 
> > My guess is that on new enough RedHat all logging goes through systemd
> > and the rsyslog configuration contains explicit option to create
> > /dev/log for compatibility reasons? But if that is the problem why is
> > the /dev/log missing after the configuration was restored and rsyslog
> > restarted?
> 
> /dev/log is created by systemd-journald. Distro rsyslog config is setup
> to use /run/systemd/journal/syslog. When rsyslog is stopped/restarted
> it deletes whatever socket was configured.
> 
> This testcase doesn't configure any log socket explicitly in rsyslog
> config. So rsyslog will use default, which is "/dev/log". Now
> when you stop/restart rsyslog it deletes /dev/log and all applications
> which use syslog(2) now fail to log anything.
> 
> I think the way it works is that journald reads message from /dev/log
> and for compatibility reasons it forwards it to /run/systemd/journal/syslog
> where rsyslog can read and process it.

Ah, now it's clear to me. And the reason why this works in SUSE without
any configuration is likely autodetection patch for rsyslog added as a
result of this bug:

https://bugzilla.novell.com/show_bug.cgi?id=747871

Anyway the patch only tries to preserve the configuration so this should
not break anything, acked, but please consider rewriting the commit
message a bit so it's a bit clearer what exactly happens, i.e. describe
a bit better that rsyslog deletes the node and it's not recreated after
the config is restored and rsyslog started again because the system
configuration overrides the default value.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

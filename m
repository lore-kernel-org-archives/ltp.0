Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XHvUt-0000py-HA
	for ltp-list@lists.sourceforge.net; Thu, 14 Aug 2014 13:55:19 +0000
Date: Thu, 14 Aug 2014 15:54:22 +0200
From: chrubis@suse.cz
Message-ID: <20140814135421.GA25594@rei.suse.de>
References: <618b542aea7f9084ee9a725572a35cbd2b8e4142.1406030190.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <618b542aea7f9084ee9a725572a35cbd2b8e4142.1406030190.git.jstancek@redhat.com>
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
> If this parameter is ommitted, rsyslog will use default,
> which is /dev/log. After rsyslog stop/restart, this node gets
> deleted. This breaks further syslog() calls on distros
> using systemd-journald when test performs cleanup, because
> rsyslog doesn't re-create /dev/log. Default distro rsyslog
> config is "/run/systemd/journal/syslog", so system ends
> up with missing /dev/log.
> 
> For example:
>   cp -f /etc/rsyslog.conf /etc/rsyslog.conf.backup
>   echo '$ModLoad imuxsock.so'  > /etc/rsyslog.conf
>   echo "*.crit            /var/log/messages"  >> /etc/rsyslog.conf
>   systemctl restart rsyslog
>   cp /etc/rsyslog.conf.backup /etc/rsyslog.conf
>   systemctl restart rsyslog # --> PROBLEM: /dev/log is now gone
> 
> This patch will include "$SystemLogSocketName" line from
> rsyslog configuration to rsyslog.conf defined by syslog* tests.

I've read this twice and I'm still unsure what happens.

My guess is that on new enough RedHat all logging goes through systemd
and the rsyslog configuration contains explicit option to create
/dev/log for compatibility reasons? But if that is the problem why is
the /dev/log missing after the configuration was restored and rsyslog
restarted?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

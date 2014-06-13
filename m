Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1WvPlz-000803-Un
	for ltp-list@lists.sourceforge.net; Fri, 13 Jun 2014 11:35:55 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WvPly-0007hX-PQ
	for ltp-list@lists.sourceforge.net; Fri, 13 Jun 2014 11:35:55 +0000
Date: Fri, 13 Jun 2014 07:35:48 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <271331452.23946492.1402659348156.JavaMail.zimbra@redhat.com>
In-Reply-To: <1401979029-12315-1-git-send-email-jjaburek@redhat.com>
References: <1249145583.18329328.1401964511429.JavaMail.zimbra@redhat.com>
	<1401979029-12315-1-git-send-email-jjaburek@redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH v2] syslog: rsyslog doesn't create empty log files
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
To: Jiri Jaburek <jjaburek@redhat.com>
Cc: ltp-list@lists.sourceforge.net



----- Original Message -----
> From: "Jiri Jaburek" <jjaburek@redhat.com>
> To: ltp-list@lists.sourceforge.net
> Sent: Thursday, 5 June, 2014 4:37:09 PM
> Subject: [LTP] [PATCH v2] syslog: rsyslog doesn't create empty log files
> 
> From: Jan Stancek <jstancek@redhat.com>
> 
> Newer versions of rsyslog don't create empty log files during startup -
> the files are created upon first logged entry instead.
> (since rsyslog git commit de77494415ae8c169949d13ed0df0af3b1949b54)
> 
> Don't check if log file gets created after service start,
> only make sure it exists after test generates a new log entry.
> 
> Signed-off-by: Jiri Jaburek <jjaburek@redhat.com>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

Thanks Jiri, looks good to me, pushed.

Regards,
Jan

------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

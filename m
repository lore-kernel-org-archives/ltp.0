Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1Soxv6-0006eV-9H
	for ltp-list@lists.sourceforge.net; Wed, 11 Jul 2012 14:29:36 +0000
Date: Wed, 11 Jul 2012 15:44:55 +0200
From: chrubis@suse.cz
Message-ID: <20120711134455.GA13301@saboteur.suse.cz>
References: <FFB336710AC24540A4636F71A9A3C38B17DFA7E41A@EXMB03.eu.tieto.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <FFB336710AC24540A4636F71A9A3C38B17DFA7E41A@EXMB03.eu.tieto.com>
Subject: Re: [LTP] WiFi test harness
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
To: filip.matusiak@tieto.com
Cc: ltp-list@lists.sourceforge.net

Hi!
> Our organization is planning to implement some kind of WiFi test
> harness. It's going to be and FOSS therefore using LTP comes as one of
> the obvious choices. For beginning we're planning to use
> mac80211_hwsim. I was browsing the archive of LTP in search for
> anything related for WiFi/WLAN and found rather little information -
> most recent one dated 2009.

That is great news. I would be happy to help with the integration with
the LTP internals.

> Latest post on WiFi in LTP list I've found is this:
> 
> (1)    http://sourceforge.net/mailarchive/forum.php?thread_name=43e72e890909271252r12459df1vc3ef263139889dc8%40mail.gmail.com&forum_name=ltp-list
> The only other thread I've found on WiFi is the one about mesh (but it has some information on proposed way forward for wireless as whole):
>
> (2)    http://sourceforge.net/mailarchive/message.php?msg_id=20189102
> 
> We may be able to extend the hostapd's mac80211_hwsim/tests proposed by Jouni (http://w1.fi/gitweb/gitweb.cgi?p=hostap.git;a=tree;f=mac80211_hwsim/tests) and integrate it to LTP.
>
> Q1) We must know if it is work that community would benefit from(?).
> * Since there's not much about this for last 3 years it was presumably not too important.

Well, if these testcases were integrated into the LTP and fully
automated they will be, once they are inside relesed LTP, executed on
several major distributions including SUSE.

I think that the prohlem here is that everybody knowledable enough to
create these testcases haven't had enough time to do so, as testing is
not as much popular as development.

> Q2) Is the latest message from Subrata Modak on the second thread above the way to go?
> * (http://sourceforge.net/mailarchive/message.php?msg_id=20192822)
> Q3) If not then what would be the preferred way forward?

Ideally the testing would be as easy as running a script that prepares
the environment, runs the tests and reports result.

If manual intervention is needed the actual testing coudn't be done as
much as possible (which is the case for daily kernel testing for
example).

> I'd be thankful for any information with regards to LTP WiFi related
> matters, especially if there was any off-record follow-up for any of
> the two discussions referred to above.

Sorry I couldn't help much here.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 4 Feb 2020 17:09:58 +0100
Subject: [LTP] [RFC PATCH 1/1] autotools: Move simple definitions out of
 m4/* to configure.ac
In-Reply-To: <20200204155703.GA16838@dell5510>
References: <20200130110753.20459-1-pvorel@suse.cz>
 <e6f7f611-7c2e-04cb-afd9-e11c4423dc3f@cn.fujitsu.com>
 <20200204155703.GA16838@dell5510>
Message-ID: <20200204160949.GA6271@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > IMO, move all simple definitions to configure.ac will make this file mess
> > likce old .gitnore file. I perfer to add function or header or macro but not
> > include struct in configure.ac.
> I think .gitignore files are different because it's content cannot be duplicated
> when they're split, but m4/ repeated some checks.
> + we already started to move configuration into configure.ac before
> (AC_CHECK_HEADERS and AC_CHECK_FUNCS).
> IMHO it's easier to search/work with single file than in many files with very little
> content.

The main reason for having a separate .gitignore files are:

* To avoid patch collisions that would happen too often

* When directory is deleted the .gitignore records are removed as well

* Also the files are much easier to maintain if there are only few
  entries, as we do not have to find stuff


In that sense the configure file is different, collisions are generally
rare and an stuffing things into m4 files is not much cleaner than
having it directly in the configure.ac

-- 
Cyril Hrubis
chrubis@suse.cz

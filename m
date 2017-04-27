From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 27 Apr 2017 04:28:27 -0400 (EDT)
Subject: [LTP] [RFC] [PATCH] tst_kvcmp: Add support for extra kernel
	versions
In-Reply-To: <20170426150641.GA6165@rei.suse.de>
References: <20170421155244.29773-1-chrubis@suse.cz>
 <343130515.905228.1493020687050.JavaMail.zimbra@redhat.com>
 <20170426150641.GA6165@rei.suse.de>
Message-ID: <1624205915.3497140.1493281707439.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> > > Jan can you please check that everything works fine when specifying extra
> > > version on RHEL? It seems that the only systems that are supported by
> > > extra
> > > kernel versions are RHEL5 and RHEL6 at the moment.
> > 
> > Should we print an error also if invalid distro is passed as parameter?
> 
> That would need a table of known distros stored into the tst_kvercmp.c
> and function to validate a distribution name, or do I miss something?

+static int compare_kver(const char *cur_kver, char *kver)
+{
+        const char *ver, *exver;
+        const char *distname = tst_kvcmp_distname(cur_kver);
+        int v1, v2, v3;
+
+        ver = strtok(kver, " ");
+
+        while ((exver = strtok(NULL, " "))) {
+                char *exkver = strchr(exver, ':');
+
+                if (!exkver) {
+                        fprintf(stderr, "Invalid extra version '%s'\n", exver);
+                        exit(2);
+                }
+
+                *(exkver++) = '\0';
+
+                if (!distname || strcmp(distname, exver))
+                        continue;
+
+                return tst_kvexcmp(exkver, cur_kver);
+        }

If distname != NULL, that means that this is a distro we recognize.
And if we reached here, after while loop, that means we didn't
match any distro specified in "kver", correct?

So, is it OK to make conclusion, that there is a problem in kver?

if (distname)
    fprintf(stderr, "distname: %s didn't match any distro in kver: %s\n", distname, kver);

Regards,
Jan

> 
> I guess that we can rewrite the code so that the kernel version
> substring and distro name are stored in an array of structures and loop
> over it so that we can say if it's valid or not but I'm not sure that
> it's worth the work.
> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 

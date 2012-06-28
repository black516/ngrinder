package com.nhncorp.ngrinder.script.service;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.nhncorp.ngrinder.script.model.Script;

public interface ScriptService {

	Page<Script> getScripts(String searchStr, Pageable pageable);

	Script getScript(long id);

	Script getScript(long id, String historyName);

	void saveScript(Script script);

	void deleteScript(long id);

	void autoSave(long id, String content);

}
//
//  NetworkError.swift
//  Chat
//
//  Created by Дарья on 26.10.2022.
//

import Foundation

public enum NetworkError {
    // Любой 500 код
    case serverError
    // Ответ не такой, как мы ожидаем
    case responseError
    // Ответа нет, отвалились по таймауту, отсуствует сеть
    case internetError
    // User already exists
    case userAlreadyExists
    // Session timed out
    case sessionTimedOut
    // Ошибка от сервера, когда пользователю не хватает места в хранилище
    case runOfSpace
    // Токен не валиден.
    case invalidToken
}

// MARK: - LocalizedError
extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .serverError:
            return "Ошибка сервера. Пожалуйста, попробуйте позже"
        case .responseError:
            return "ой, что-то пошло не так"
        case .internetError:
            return "Нет соединения с интернетом"
        case .userAlreadyExists:
            return "Пользователь с этим адресом уже существует"
        case .runOfSpace:
            return "Закончилось место"
        case .sessionTimedOut:
            return "Ваша сессия истекла"
        case .invalidToken:
            return "Ошибка авторизации"
        }
    }
    
    public var recoverySuggestion: String? {
        switch self {
        case .serverError:
            return "Сервер недоступен"
        case .responseError:
            return "Проверьте правильность вводимых данных"
        case .internetError:
            return "Пожалуйста, проверьте ваше интернет-соединение"
        case .userAlreadyExists:
            return "Аккаунт зарегистрирован воспользуйтесь восстановлением пароля"
        case .runOfSpace:
            return "Пожалуйста, освободите место в памяти телефона"
        case .sessionTimedOut:
            return "Не удалось получить новые аутентификационные данные"
        case .invalidToken:
            return "Нужно войти в приложение заново"
        }
    }
    
    var errorMessage: String? {
        switch self {
        case .userAlreadyExists:
            return "User already exists"
        default:
            return ""
        }
    }
}

